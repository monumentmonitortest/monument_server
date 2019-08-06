import React from 'react';
import 'babel-polyfill';

import Submission from './Submission.jsx'


export default class Search extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      site: '',
      type: '',
      reliable: false,
      submissions: [],
      firstLink: '',
      lastLink: '',
      nextLink: '',
      prevLink: '',
      selfLink: '',
      perPage: 10
    };
  }
  

  handleSubmit = event => {
    event.preventDefault()
    this.refineView(this.state.reliable, this.state.site, this.state.type)
  }

  handlePagination = (event) => {
    event.preventDefault()
    this.refineView('','','', event.target.href)
  }
  
  handleInputChange = event => {
    const target = event.target
    const value = target.type === 'checkbox' ? target.checked : target.value;
    const name = target.id;
    
    this.setState({
      [name]: value
    });
  }
  
  handlePaginationCount = event => {
    event.preventDefault()
    // this.setState({perPage: event.target.innerHTML})
    // const params = {page: {size: 4}}
    const url = encodeURI(`api/v1/submissions?bespoke_size=${event.target.innerHTML}`)
    // debugger
    
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

      this.setState({firstLink: json.links.first})
      this.setState({lastLink: json.links.last})
      this.setState({nextLink: json.links.next})
      this.setState({prevLink: json.links.prev})
      this.setState({selfLink: json.links.self})
    } catch (error) {
      console.log(error)
    }
  }

  refineView = async (reliable, site, type, url) => {
    try {
      // debugger
      const requestURL = url ? url : `api/v1/submissions?reliable=${reliable}&site_filter=${site}&type_filter=${type}`
      const response = await fetch(requestURL)
      if (!response.ok) {
        throw Error(response.statusText)
      }
      const json = await response.json()
      this.setState({submissions: json.data})
      this.setState({firstLink: json.links.first})
      this.setState({lastLink: json.links.last})
      this.setState({nextLink: json.links.next})
      this.setState({prevLink: json.links.prev})
      this.setState({selfLink: json.links.self})
    } catch (error) {
      console.log(error)
    }
  }

  
  render() {
    return (
      <div className="ui raised segment no padding">
        <form onSubmit={this.handleSubmit}>
          <label>
            Useful?
            <input
              name="useful"
              id="reliable"
              type="checkbox"
              checked={this.state.reliable}
              onChange={this.handleInputChange} />
          </label>

          <label>
            Site:
            <input type="text" id="site" value={this.state.site} onChange={this.handleInputChange} />
          </label>

          <label>
            Type:
            <input type="text" id="type" value={this.state.type} onChange={this.handleInputChange} />
          </label>

          
          <button type="submit" onClick={this.handleSubmit}>
            Search
          </button>
        </form>

        <div className="w-100-l relative z-1">
          <div className="flex flex-wrap justify-between submissions ph3 ph4-l">
              {this.state.submissions.map((submission, i)=>(<Submission {...submission} key={i} />))}
          </div>
        </div>

        {/* TODO - refctor this out into different component */}
        <div>
          <ul className="list flex">
            <li className="ph2">
              <a href={this.state.firstLink} onClick={this.handlePagination}>First Page</a>
            </li>
            <li className="ph2">
              <a href={this.state.prevLink} onClick={this.handlePagination}>Previous Page</a>
            </li>
            
            <li className="ph2">
              <a href={this.state.nextLink} onClick={this.handlePagination}>Next page</a>
            </li>
            <li className="ph2">
              <a href={this.state.lastLink} onClick={this.handlePagination}>Last Page</a>
            </li>
          </ul>
            <li>Show per page</li>
            <li><a onClick={this.handlePaginationCount}>10</a></li>
            <li><a onClick={this.handlePaginationCount}>25</a></li>
            <li><a onClick={this.handlePaginationCount}>50</a></li>
        </div>
      </div>
    );
  }
}