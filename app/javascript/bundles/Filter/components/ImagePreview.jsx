import React from 'react';

class ImagePreview extends React.Component {
  constructor(props) {
    super(props);
  }

  render() {
    const imageCompare = this.props.imageCompare
    const imagePresent = imageCompare && imageCompare[this.props.index]
    let preview;

    if (imagePresent) {
      preview = <span className="flex items-center"><img src={imageCompare[this.props.index]} className="h3 mh3" />Image selected</span>
    } else {
      preview =  <span>Select image to compare</span>
    }

    return (
      <div>
        {preview}
      </div>
    );
  }
}

export default ImagePreview