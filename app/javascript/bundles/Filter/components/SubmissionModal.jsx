import React from 'react';
import downloadIcon from 'images/download.png'

export default class SubmissionModal extends React.Component {
  constructor(props) {
    super(props);
  }
  
  render() {
    const url = this.props.attributes['image-url']
    const date = new Date(this.props.attributes['record-taken'])
    const name = this.props.attributes['site-name']
    const type = this.props.attributes['type-name'].toLowerCase()
    const comment = this.props.attributes['type-comment']
    const tags = this.props.attributes['ai-tags']
    
    return (
      <div className="flex flex-wrap flex-column h-100">
        <div className="w-75 h-100">
          <img src={url} className="h-100 mw-100 mh-100 pr6"/>
        </div>

        {/* Text stuff */}
        <div className="w-25 ph3">
          
          <span className="w-100 flex justify-between">
            <svg className={type}>
              <circle cx="15" cy="15" r="15"/>
            </svg>
            <button onClick={this.props.closeModal}>Close Modal</button>
          </span>

          <span className="w-100">
            <h2 className="f2 tr mt3 mb2">{date.toLocaleDateString("en-GB")}</h2>
            <h2 className="w-100 tr f1 mb5">{name}</h2>
          </span>
          <div>
            <div className="fw9">AI Tags:</div>
            <ul className="list ph3">
              {tags.map((tag) => {
                return <li className="mb0">{tag[0]}: {tag[1].toFixed(2)}</li>
              })}
            </ul>
          </div>
          <div>
            <div className="fw9">Comments: </div>
            <div className="ph3">{comment}</div>
          </div>

          <a href={url} className="download-icon" download>
            <img src={downloadIcon} />
          </a>
        </div>
      </div>
    )
  }
}