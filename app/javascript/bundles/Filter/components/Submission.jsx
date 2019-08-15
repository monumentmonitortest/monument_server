import React from 'react';
import LazyLoad from 'react-lazy-load';

import ImageLoader from './ImageLoader.jsx'

export default class Submission extends React.Component {
  constructor(props) {
    super(props);
  }
  
  render() {
    const image =  this.props.attributes["image-url"] || ""
    const site  = this.props.attributes["site-name"] || ""
    const type  = this.props.attributes["type-name"] || ""
    const recordTaken  = this.props.attributes["record-taken"] || ""
    const submissionId = this.props.id
    const submissionClass = `submission mb6 br4 ${type.toLowerCase()}`

    return (
      <div className={submissionClass}>
        <div className="aspect-ratio aspect-ratio--3x4">
          <div className="ph3 pv4" >
            <div className="aspect-ratio--object">
              <h1 className="f2 f3-l mv0 ph3 pt4 pb2 pr2 lh-title">{site}</h1>

              <span className="flex flex-wrap">
                <h2 className="f2 ph3 pb3 w-70">{recordTaken}</h2>
                <span className="w-25 flex flex-wrap">
                  <label className="mr3">Compare</label>
                  <input name="compare" 
                         type="checkbox" 
                         value={image}
                         className="mt2 mb0" 
                         onChange={this.props.handleSelectCompare}/>
                </span>
              </span>

              <div className="h-85 overflow-hidden">
                <LazyLoad  
                  debounce={false}
                  offsetVertical={500}>
                    <ImageLoader 
                      src={image}
                      submissionId={submissionId}
                    />
                </LazyLoad>        
              </div>
            </div>
          </div>
        </div>
      </div>
    )
  }
}