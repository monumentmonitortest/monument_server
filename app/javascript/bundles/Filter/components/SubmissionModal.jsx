import React from 'react';

export default class SubmissionModal extends React.Component {
  constructor(props) {
    super(props);
  }
  
  render() {
    const url = this.props.attributes['image-url']
    const date = this.props.attributes['record-taken']
    const name = this.props.attributes['site-name']
    const type = this.props.attributes['type-name'].toLowerCase()
    const tags = this.props.attributes['tags']
    
    return (
      <div className="flex flex-wrap flex-column h-100">
        <div className="w-75 h-100">
          <img src={url} className="h-100 mw-100 mh-100 pr6"/>
        </div>
        <div className="">
          
          <span className="w-100 flex justify-between">
            <svg className={type}>
              <circle cx="15" cy="15" r="15"/>
            </svg>
            <button onClick={this.props.closeModal}>Close Modal</button>
          </span>

          <span className="w-100">
            <h2 className="f2 tr mt3 mb2">{date}</h2>
            <h2 className="w-100 tr f1 mb5">{name}</h2>
          </span>

          <div>
            here will go loads and loads of comments
          </div>
        </div>
      </div>
    )
  }
}