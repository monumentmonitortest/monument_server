import PropTypes from 'prop-types';
import React from 'react';

import Submission from './Submission.jsx'


export default class FilterHome extends React.Component {
  static propTypes = {
    name: PropTypes.string.isRequired, // this is passed from the Rails view
  };

  /**
   * @param props - Comes from your rails view.
   */
  constructor(props) {
    super(props);

    // How to set initial state in ES6 class syntax
    // https://reactjs.org/docs/state-and-lifecycle.html#adding-local-state-to-a-class
    this.state = { submissions: this.props.submissions };
  }

  updateName = (submissions) => {
    this.setState({ submissions });
  };

  renderSubmissions = () => {
    const submissions = JSON.parse(this.state.submissions)
    {submissions.map(submission => <Submission {...submission} />)}
    // return submissions.map(submission => {
    //   return (
    //     <tr>
    //       <td>{submission.id}</td>
    //       <td>{submission.reliable}</td>
    //       <td>{submission.image}</td>
    //     </tr>
    //   );
    // })
}

render() {
  const submissions = JSON.parse(this.state.submissions)

    return (
      <div>
        <h3>
          Here we have a load of Submissions
        </h3>
        <form >
          <label htmlFor="name">
            This will be a form to filterHome the submissions
          </label>
          {/* <input
            id="name"
            type="text"
            value={this.state.name}
            onChange={(e) => this.updateName(e.target.value)}
          /> */}
        </form>

        <div>
          And here are the submissions:
          {/* {this.state.submissions}! */}
          <div className="flex flex-wrap container">
            {/* {this.renderSubmissions()} */}
            {submissions.map(submission => <Submission {...submission} />)}
          </div>
        </div>  
        <hr />
      </div>
    );
  }
}
