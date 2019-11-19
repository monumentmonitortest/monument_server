import PropTypes from 'prop-types';
import React from 'react';

export const SubmissionContext = React.createContext();

export default class SubmissionsContextProvider extends React.Component {
  state = {
    contextSubmissions: [],
    aWord: 'hi'
  }
  render() {
    return (
      <SubmissionContext.Provider value={{...this.state}}>
        {this.props.children}
      </SubmissionContext.Provider>
    );
  }
}

