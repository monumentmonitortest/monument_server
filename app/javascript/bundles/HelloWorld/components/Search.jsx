import React from 'react';
import 'babel-polyfill';

export default class Search extends React.Component {
  constructor(props) {
    super(props);

    // How to set initial state in ES6 class syntax
    // https://reactjs.org/docs/state-and-lifecycle.html#adding-local-state-to-a-class
    this.state = {
      site: 'Clava',
      type: '',
      reliable: false
    };
  }


  handleSubmit = event => {
    event.preventDefault()
    console.log(this.state)
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

  refineView = async (reliable, site, type) => {
    try {
      const response =  await fetch(
        `api/v1/submissions?reliable=${reliable}&site=${site}&type${type}`
      );
      
      const {data} = await response.json()
      debugger
      console.log(data)

    } catch (error) {
      console.log("there has been an error in fetching the data!")
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
      </div>
    );
  }
}