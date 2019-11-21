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
    const submissionClass = `submission ${type.toLowerCase()}`

    return (
      <div className={submissionClass}>
        <div className="aspect-ratio aspect-ratio--3x4" id="submission-card">
          <div className="aspect-ratio--object">

            <div className="positioner">

              <div className="overflow-hidden submission-image-holder">
                <LazyLoad  
                  debounce={false}
                  offsetVertical={500}
                  className="w-100 h-100">
                    <ImageLoader 
                      src={image}
                      submissionId={submissionId}
                    />
                </LazyLoad>        
              </div>

                  <div className="submission-text pa2">
                    <h1 className="f4 f3-l lh-title mb0 w-100">{site}</h1>
                    <span className="flex flex-wrap">
                      <h2 className="f4 f3-l w-50 mb0 inline">{recordTaken}</h2>
                      <span className="w-50 flex flex-wrap">
                        <input name="compare" 
                                type="checkbox" 
                                value={image}
                                className="mb0 mr3 mt2" 
                                onChange={this.props.handleSelectCompare}/>
                        <label className="inline">Compare</label>
                      </span>
                    </span>
                  </div>

            </div>
            
          </div>
        </div>
      </div>
    )
  }
}