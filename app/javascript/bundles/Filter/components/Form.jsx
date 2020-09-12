import React, { useState } from 'react';
import MultiSelect from "react-multi-select-component";

export default class Form extends React.Component {
  constructor(props) {
    super(props);
    
    this.state = {
      site: '',
      type: '',
      // tag: '',
      selected: [],
      reliable: false
    }
  }

  handleSubmit = event => {
    event.preventDefault()
    this.props.refineView({reliable: this.state.reliable, 
                           site: this.state.site, 
                           type: this.state.type,
                           tag: this.state.tag})
  }

  handleInputChange = event => {
    const target = event.target
    const value = target.type === 'checkbox' ? target.checked : target.value;
    const name = target.id;

    this.setState({
      [name]: value
    });
  }

  setSelectedTag = event => {
    // this puts the whole event object in state
    // so work has to be done in handle submit to reduce get just values
    const tag = event
    this.setState({selected: tag})
  }
  
  render() {
    const {selected} = this.state
    const options = this.props.tags.map(tag => { return {label: tag, value: tag}})
    const selectString = {
                            selectSomeItems: "Select tags",
                          }
    return (
      <form className="ph4 pv4 mb0 br1" onSubmit={this.handleSubmit}>
          <div className="flex flex-wrap items-center justify-between">
            <span className="h-25 w-100">
              <select id="site" className="dark-color w-100" onChange={this.handleInputChange}>
                <option defaultValue="">Select Site</option>
              {this.props.siteNames.sort().map((site, i) => 
                <option 
                  value={site} 
                  key={i}
                  className="dark-color w-100">{site}</option>)}
              </select>
            </span>

            <span className="h-25 w-100">
              <input 
                placeholder="Select submission type"
                type="text" 
                id="type" 
                className="black w-100"
                value={this.state.type} 
                onChange={this.handleInputChange} />
            </span>

            <span className="h-25 w-100">
              <MultiSelect
                options={options}
                value={selected}
                onChange={this.setSelectedTag}
                labelledBy={"Select"}
                overrideStrings={selectString}
                />
            </span>
              
            {/* <span className="h-25">
              <select id="tag" className="dark-color w-100" onChange={this.handleInputChange}>
                <option defaultValue="">Select Tag</option>
                  {this.props.tags.map((tag) => 
                    <option 
                      value={tag} 
                      key={tag}
                      className="dark-color w-100">{tag}</option>)}
              </select>
            </span> */}

            <span className="h-25">
              <button className="flex center mt4 white-background dark-color" type="submit" onClick={this.handleSubmit}>
                Search
              </button>
            </span>
          </div>
          
        </form>
    )
  }
}