import React from 'react';

export default class ZipForm extends React.Component {
  constructor(props) {
    super(props);
  }

  handleSubmit = event => {
    event.preventDefault()
    console.log("FiRED")
    // this returns a string of just the labels for selected tags
    const {email} = this.props
    const {site} = this.props
    const {type} = this.props    
    const tags = this.props.selected.map(obj => { return obj.label})
    const url = `api/v1/zip_images?site_name=${site}&email=${email}&type=${type}&tags=${tags}`

    fetch(url)
      .then(response => response.json())
      .then(data => console.log(data, "This is the data"))
      .catch(error => console.log(error))
    
  }


  render() {
    return (
      <div className="h-25 w-100 flex flex-column">
        <button className="mt4 white-background dark-color w-100 centre" type="submit" onClick={this.handleSubmit}>
          Zip images
        </button>
        <p className="f6">
          This will collect your selected images and zip them into a compressed file. These will then be emailed to your login address.
          Please leave up to an hour for this process, depending on how many images you have selected
        </p>
      </div>
    )
  }
}