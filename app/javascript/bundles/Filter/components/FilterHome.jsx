import PropTypes from 'prop-types';
import React from 'react';
import ResultsManager from './ResultsManager.jsx'
import SubmissionsContextProvider from './SubmissionContext.jsx'
import DataVis from './DataVis.jsx'
import Nav from './Nav.jsx'

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
      pageNumber: '', // what page we're on at the moment
      viewDataVis: false, // viewing submissions or data view
      navCollapsed: false
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

      this.setState({
        submissions: json.data,
        totalSubmissions: total,
        pageNumber: '1',
        links: json.links
      })
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
    try {
      const requestURL = url ? url : `api/v1/submissions?reliable=${reliable}&site_filter=${site}&type_filter=${type}&bespoke_size=${size}&page=${pageNumber}`
      const response = await fetch(requestURL)
      if (!response.ok) {
      throw Error(response.statusText)
    }
      const json = await response.json()
      const total = await response.headers.get("Total")
      const newPageNumber = await response.headers.get("current-page")
      this.setState({
        submissions: json.data,
        reliable: reliable,
        site: site, 
        type: type, 
        pageSize: size, 
        totalSubmissions: total,
        pageNumber: newPageNumber
      })
      json.links && this.setState({links: json.links})
    } catch (error) {
      console.log(error)
    }
  }

  handleToggle = event => {
    const target = event.target.textContent
    if (target == "Data") {
      this.setState({viewDataVis: true})
    } else if (target == "Images") {
      this.setState({viewDataVis: false})
    }
  }

  handleToggleNav = () => {
    this.setState({navCollapsed: !this.state.navCollapsed});
  }
  
  render() {
    const {navCollapsed} = this.state
    let data
    if (this.state.viewDataVis) {
      data = <DataVis className={navCollapsed ? "collapsed" : "full"}/>
    } else {
      data = <ResultsManager 
                siteNames={this.props.siteNames} 
                submissions={this.state.submissions} 
                links={this.state.links} 
                totalSubmissions={this.state.totalSubmissions}
                pageNumber={this.state.pageNumber}
                refineView={this.refineView}
                updateState={this.updateState} />
    }


    return (
      <div>
        <SubmissionsContextProvider>
          <Nav 
            viewDataVis={this.state.viewDataVis}
            handleToggle={this.handleToggle}
            refineView={this.refineView}
            siteNames={this.props.siteNames}
            handleToggleNav={this.handleToggleNav}
            navCollapsed={this.state.navCollapsed}
             />
          <main className={navCollapsed ? "collapsed ph4-ns" : "full ph4-ns"}>
            {data}
          </main>
        </SubmissionsContextProvider>
      </div>
    );
  }
}


