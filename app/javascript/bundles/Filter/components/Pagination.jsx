import React from 'react';

export default class Pagination extends React.Component {
  constructor(props) {
    super(props);
  }
  
  render() {
    return (
      <span className="ph3">
        <a href={this.props.link} onClick={this.props.handlePagination}>{this.props.direction}</a>
      </span>
    )
  }
}