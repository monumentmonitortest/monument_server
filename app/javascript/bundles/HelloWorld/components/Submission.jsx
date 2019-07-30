import React from 'react';
import { timingSafeEqual } from 'crypto';

export default class Submission extends React.Component {
  constructor(props) {
    super(props);
    debugger
  }

  render() {
    return (
      <div>
        <div className="relative">
          hello
          {/* a submission number: {timingSafeEqual.props.id} */}
          {/* <Info {...this.props} {...this.state} /> */}
          {/* <img src={`${this.props.image.url}`} className="db" /> */}
        </div>
      </div>
    );
  }
}