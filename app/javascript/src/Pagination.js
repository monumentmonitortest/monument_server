import React from 'react';

export default class Pagination extends React.Component {
  constructor(props) {
    super(props);
  }
  
  render() {
    return (
      <li className="">
        <a className="pointer mh2 tc" href={this.props.link} onClick={this.props.handlePagination}>{this.props.direction}</a>
      </li>
    )
  }
}