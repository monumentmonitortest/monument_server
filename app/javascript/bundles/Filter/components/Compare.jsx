import React from 'react';

import ImagePreview from './ImagePreview.jsx'

export default class Compare extends React.Component {
  constructor(props) {
    super(props);
  }

  render() {
    return (
      <div className="flex flex-wrap justify-around items-center h4 mt0 mb5 sticky blue-background">
        <div className="pv4 tc w-25"><ImagePreview index="0" imageCompare={this.props.imageCompare} /></div>
        <div className="pv4 tc w-25"><ImagePreview index="1" imageCompare={this.props.imageCompare} /></div>
        <div className="pv3 tc w-50"><button>Compare images</button></div>
      </div>
    )
  }
}