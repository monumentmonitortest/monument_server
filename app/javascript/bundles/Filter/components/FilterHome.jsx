import PropTypes from 'prop-types';
import React from 'react';
import Search from './Search.jsx'


export default class FilterHome extends React.Component {
  static propTypes = {
    siteNames: PropTypes.array.isRequired, // this is passed from the Rails view
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
        <nav>
        <div>
          <img></img>
      
          <h2>add an icon for assistance</h2>
          <h2>add search functionality here</h2>
        </div>
      </nav>
      
      <main>
        <Search siteNames={this.props.sitenames}/>
      </main>
    </div>
    );
  }
}
