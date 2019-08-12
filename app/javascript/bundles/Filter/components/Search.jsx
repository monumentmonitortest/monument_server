import React from 'react';
import 'babel-polyfill';

import Submission from './Submission.jsx'
import Pagination from './Pagination.jsx'
import Form from './Form.jsx'
import Key from './Key.jsx'
import Compare from './Compare.jsx'

export default class Search extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      site: '',
      type: '',
      reliable: false,
      submissions: [],
      links: [],
      imageCompare: [],
      pageSize: 10, // how many submissons per page
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

  handlePaginationUrl = (event) => {
    event.preventDefault()
    const pageUrl = event.target.href
    this.refineView({url: pageUrl})
  }
  
  handlePaginationCount = event => {
    event.preventDefault()
    const pageSize = event.target.innerHTML
    this.setState({pageSize: pageSize})
    this.refineView({size: pageSize})
  }
  
  handleSelectCompare = event => {
    const images = this.state.imageCompare
    const imageUrl = event.target.value
    var filteredImages = images
    if (images.includes(imageUrl)) {
      console.log('image in array')
      filteredImages = filteredImages.filter(image => image !== imageUrl)
    } else {
      if (images.length > 1) {
        filteredImages.shift()
      }
      filteredImages.push(imageUrl)
    }

    this.setState({imageCompare: filteredImages})
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

  
  render() {
    const {totalSubmissions} = this.state
    const {pageNumber} =  this.state
    const {pageSize} = this.state
    const pageNumbers = Math.round(Number(totalSubmissions) / Number(pageSize))

    return (
      <div className="ui raised segment no padding">
        <Form refineView={this.refineView} siteNames={this.props.siteNames}/>
        <Key />
        <Compare imageCompare={this.state.imageCompare}/>
        
        <span className="mh2">{totalSubmissions} submissions found, page {pageNumber} of {pageNumbers}.</span>
        <ul className="list flex flex-wrap items-center pa0 ma0">
          <li className="pointer mh2 tc">Navigate to:</li>
          { Object.keys(this.state.links).map((keyName, i) => ( 
            <Pagination 
              direction={keyName}
              link={this.state.links[keyName]}
              handlePagination={this.handlePaginationUrl}
              key={i} />
            ))}
        </ul>
        
        <ul className="list flex flex-wrap items-center pa0 ma0 mb4">
          <li className="pointer mh2 tc">Show per page:</li>
          <li className="pointer mh2 tc"><a onClick={this.handlePaginationCount}>10</a></li>
          <li className="pointer mh2 tc"><a onClick={this.handlePaginationCount}>25</a></li>
          <li className="pointer mh2 tc"><a onClick={this.handlePaginationCount}>50</a></li>
        </ul>

        <div className="w-100-l relative z-1">
          <div className="flex flex-wrap justify-between submissions ph3 ph4-l">
              {this.state.submissions.map((submission, i)=>(<Submission {...submission} key={i} handleSelectCompare={this.handleSelectCompare} />))}
          </div>
        </div>
      </div>
    )
  }
}