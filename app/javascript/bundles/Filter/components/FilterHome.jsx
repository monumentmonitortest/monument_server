import PropTypes from 'prop-types';
import React from 'react';
import ResultsManager from './ResultsManager.jsx'
import Form from './Form.jsx'
import SubmissionsContextProvider from './SubmissionContext.jsx'



export default class FilterHome extends React.Component {
  static propTypes = {
    siteNames: PropTypes.array.isRequired, // this is passed from the Rails view
  };

  /**
   * @param props - Comes from your rails view.
   */
  constructor(props) {
    super(props);
    this.state = {     
      site: '',
      type: '',
      reliable: false, 
      submissions: [],
      links: [],
      totalSubmissions: '', // how many submissions there are
      pageNumber: '' // what page we're on at the moment
    };
  }

  async componentDidMount() {
    try {
      const response = await fetch('api/v1/submissions')
      if (!response.ok) {
        throw Error(response.statusText)
      }
      const json = await response.json()
      const total = await response.headers.get("Total")

      this.setState({submissions: json.data,
                     totalSubmissions: total,
                     pageNumber: '1',
                     links: json.links})
    } catch (error) {
      console.log(error)
    }
  }

  refineView = async ({reliable=this.state.reliable, 
    site=this.state.site, 
    type=this.state.type, 
    size=this.state.pageSize,
    pageNumber=this.state.pageNumber,
    url=""}) => {
      // debugger
    try {
    const requestURL = url ? url : `api/v1/submissions?reliable=${reliable}&site_filter=${site}&type_filter=${type}&bespoke_size=${size}&page=${pageNumber}`
    const response = await fetch(requestURL)
    if (!response.ok) {
    throw Error(response.statusText)
    }
    const json = await response.json()
    const total = await response.headers.get("Total")
    const newPageNumber = await response.headers.get("current-page")

    this.setState({submissions: json.data,
      reliable: reliable,
      site: site, 
      type: type, 
      pageSize: size, 
      totalSubmissions: total,
      pageNumber: newPageNumber})
    json.links && this.setState({links: json.links})
    } catch (error) {
    console.log(error)
    }
  }

  updateState(state, newState) {
    this.setState({state: newState})
  }
 

  render() {
    return (
      <div className='grid'>
        <SubmissionsContextProvider>
          <nav>
            <Form siteNames={this.props.siteNames} refineView={this.refineView} />
          </nav>
          <main>
            <ResultsManager siteNames={this.props.siteNames} 
                            submissions={this.state.submissions} 
                            links={this.state.links} 
                            totalSubmissions={this.state.totalSubmissions}
                            pageNumber={this.state.pageNumber}
                            refineView={this.refineView}
                            updateState={this.updateState} />
          </main>
        </SubmissionsContextProvider>
      </div>
    );
  }
}


