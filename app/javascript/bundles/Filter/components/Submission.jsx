import React from 'react';

export default class Submission extends React.Component {
  constructor(props) {
    super(props);

  }
  
  render() {
    const image =  this.props.attributes["image-url"] || ""
    const site  = this.props.attributes["site-name"] || ""
    const type  = this.props.attributes["type-name"] || ""
    const recordTaken  = this.props.attributes["record-taken"] || ""


    return (
      <div className='submission mb4'>
        <div className="aspect-ratio aspect-ratio--3x4 pointer bg-black">
          <div className="ph3 pv4 aspect-ratio--object mix-overlay" >
            <div className="flex flex-column relative z-2">
              <h1 className="f2 f3-l mv0 ttu pr2 lh-title">{site}</h1>
              <h2 className="f2">{type}</h2>
              <h2 className="f2">{recordTaken}</h2>
              <img src={image} />          
            </div>
          </div>
        </div>
      </div>
    )
  }
}