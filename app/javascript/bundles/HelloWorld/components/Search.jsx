import React from 'react';
import 'babel-polyfill';

import Submission from './Submission.jsx'


export default class Search extends React.Component {
  constructor(props) {
    super(props);

    // How to set initial state in ES6 class syntax
    // https://reactjs.org/docs/state-and-lifecycle.html#adding-local-state-to-a-class
    this.state = {
      site: '',
      type: '',
      reliable: false,
      submissions: []
    };
  }
  

  handleSubmit = event => {
    event.preventDefault()
    this.refineView(this.state.reliable, this.state.site, this.state.reliable)
  }

  handleInputChange = event => {
    const target = event.target
    const value = target.type === 'checkbox' ? target.checked : target.value;
    const name = target.id;
    
    this.setState({
      [name]: value
    });
  }

  renderSubmissions = () => {
    // const submissions = this.state.submissions
    // if (submissions.length < 1) {
    //   return(<div>Whoops! No submissions of that type!</div>)
    // } else {
    //   return({submissions})
    // }
  }

  async componentDidMount() {
    try {
      const response = await fetch('api/v1/submissions')
      if (!response.ok) {
        throw Error(response.statusText)
      }
      const json = await response.json()
      // debugger
      this.setState({submissions: json.data})
    } catch (error) {
      console.log(error)
    }
  }

  refineView = async (reliable, site, type) => {
    console.log('triggered')
  }

  
  render() {
    const { submissions = [] } = this.props
    return (
      <div className="ui raised segment no padding">
        <form onSubmit={this.handleSubmit}>
          <label>
            Useful?
            <input
              name="useful"
              id="reliable"
              type="checkbox"
              checked={this.state.reliable}
              onChange={this.handleInputChange} />
          </label>

          <label>
            Site:
            <input type="text" id="site" value={this.state.site} onChange={this.handleInputChange} />
          </label>

          <label>
            Type:
            <input type="text" id="type" value={this.state.type} onChange={this.handleInputChange} />
          </label>

          
          <button type="submit" onClick={this.handleSubmit}>
            Search
          </button>
        </form>
          {this.state.submissions.map(submission =>(<Submission {...submission} />))}
      </div>
    );
  }
}