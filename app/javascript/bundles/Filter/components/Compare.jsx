import React from 'react';

export default class Compare extends React.Component {
  constructor(props) {
    super(props);
  }
  
  render() {
    return (
      <div className="flex flex-wrap justify-around items-center mv3 sticky">
        <div className="pv4 tc w-25">select image to compare</div>
        <div className="pv4 tc w-25">Select image to compare</div>
        <div className="pv3 tc w-50"><button>Compare images</button></div>
      </div>
    )
  }
}