import PropTypes from 'prop-types';
import React from 'react';

import Submission from './Submission.jsx'

// THIS IS NOT CURRENTLY USED!
export default class FilterHome extends React.Component {
  static propTypes = {
    name: PropTypes.string.isRequired, // this is passed from the Rails view
  };

  /**
   * @param props - Comes from your rails view.
   */
  constructor(props) {
    super(props);
  }

render() {
    return (
      <div>
        <h3>
          Here we have a load of Submissions, and some nice design, and you can filter them
        </h3>
      </div>
    );
  }
}
