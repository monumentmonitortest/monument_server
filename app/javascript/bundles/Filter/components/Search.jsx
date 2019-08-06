import React from 'react';
import 'babel-polyfill';

import Submission from './Submission.jsx'
import Pagination from './Pagination.jsx'
import Form from './Form.jsx'

export default class Search extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      site: '',
      type: '',
      reliable: false,
      submissions: [],
      links: []
    };
  }
  

  handlePagination = (event) => {
    event.preventDefault()
    this.refineView('','','', event.target.href)
  }
  
  
  handlePaginationCount = event => {
    event.preventDefault()
    const url = encodeURI(`api/v1/submissions?bespoke_size=${event.target.innerHTML}`)
    this.refineView('','','', url)
  }

  async componentDidMount() {
    try {
      const response = await fetch('api/v1/submissions')
      if (!response.ok) {
        throw Error(response.statusText)
      }
      const json = await response.json()

      this.setState({submissions: json.data})
      json.links && this.setState({links: json.links})
    } catch (error) {
      console.log(error)
    }
  }

  refineView = async (reliable, site, type, url) => {
    try {
      const requestURL = url ? url : `api/v1/submissions?reliable=${reliable}&site_filter=${site}&type_filter=${type}`
      const response = await fetch(requestURL)
      if (!response.ok) {
        throw Error(response.statusText)
      }
      const json = await response.json()
      this.setState({submissions: json.data})
      json.links && this.setState({links: json.links})
    } catch (error) {
      console.log(error)
    }
  }

  
  render() {
    return (
      <div className="ui raised segment no padding">
        
        <Form refineView={this.refineView}/>
        
        <div className="flex flex-wrap justify-around items-center mb6">
          <div className="pv4 tc w-25 whatsapp">WhatsApp</div>
          <div className="pv4 tc w-25 twitter">Twitter</div>
          <div className="pv4 tc w-25 instagram">Instagram</div>
          <div className="pv4 tc w-25 email">Email</div>
        </div>

        <div className="w-100-l relative z-1">
          <div className="flex flex-wrap justify-between submissions ph3 ph4-l">
              {this.state.submissions.map((submission, i)=>(<Submission {...submission} key={i} />))}
          </div>
        </div>

        <ul className="list flex flex-wrap items-center pa0 ma0">
          <li className="pointer mh2 tc">Navigate to:</li>
          { Object.keys(this.state.links).map((keyName, i) => ( 
            <Pagination 
            direction={keyName}
            link={this.state.links[keyName]}
            handlePagination={this.handlePagination}
            />
            ))}
        </ul>

        <ul className="list flex flex-wrap items-center pa0 ma0">
          <li className="pointer mh2 tc">Show per page:</li>
          <li className="pointer mh2 tc"><a onClick={this.handlePaginationCount}>10</a></li>
          <li className="pointer mh2 tc"><a onClick={this.handlePaginationCount}>25</a></li>
          <li className="pointer mh2 tc"><a onClick={this.handlePaginationCount}>50</a></li>
        </ul>
      </div>
    );
  }
}