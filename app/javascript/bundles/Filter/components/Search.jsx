import React from 'react';
import 'babel-polyfill';

import Submission from './Submission.jsx'


export default class Search extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      site: '',
      type: '',
      reliable: false,
      submissions: []
    };
  }
  

  handleSubmit = event => {
    event.preventDefault()
    this.refineView(this.state.reliable, this.state.site, this.state.type)
  }

  handleInputChange = event => {
    const target = event.target
    const value = target.type === 'checkbox' ? target.checked : target.value;
    const name = target.id;

    this.setState({
      [name]: value
    });
  }

  async componentDidMount() {
    try {
      const response = await fetch('api/v1/submissions')
      if (!response.ok) {
        throw Error(response.statusText)
      }
      const json = await response.json()

      this.setState({submissions: json.data})
    } catch (error) {
      console.log(error)
    }
  }

  refineView = async (reliable, site, type) => {
    try {
      const response = await fetch(`api/v1/submissions?reliable=${reliable}&site_filter=${site}&type_filter=${type}`)
      if (!response.ok) {
        throw Error(response.statusText)
      }
      const json = await response.json()
      this.setState({submissions: json.data})
    } catch (error) {
      console.log(error)
    }
  }

  
  render() {
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

        <div className="w-100-l relative z-1">
          <div className="flex flex-wrap justify-between submissions ph3 ph4-l">
              {this.state.submissions.map((submission, i)=>(<Submission {...submission} key={i} />))}
          </div>
        </div>
      </div>
    );
  }
}