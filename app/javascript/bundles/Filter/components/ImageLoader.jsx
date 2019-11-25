import React from "react";
import * as loadImage from 'blueimp-load-image'

const _loaded = {};

class ImageLoader extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      loaded: _loaded[this.props.src],
      imgSrc: "",
      prevImage: ""
    };
  }

  //define our loading and loaded image classes
  static defaultProps = {
    className: "w-100 pointer",
    loadingClassName: "img-loading",
    loadedClassName: "img-loaded"
  };

  // load the image first, and get it orientated
  componentDidMount() {
    loadImage( this.props.src, (img) => {
      var base64data = img.toDataURL('image/jpeg'); this.setState({ imgSrc: base64data }); 
    }, { orientation: true, });
  }

  // when searching, refining - we need to re-render component with new image url
  componentDidUpdate(prevProps) {
    if (this.props.submissionId !== prevProps.submissionId) {
      this.setState({loaded: false})
      loadImage( this.props.src, (img) => {
        var base64data = img.toDataURL('image/jpeg'); this.setState({ imgSrc: base64data }); 
      }, { orientation: true, });
    }
  }

  //image onLoad handler to update state to loaded
  onLoad = () => {
    _loaded[this.props.src] = true;
    this.setState(() => ({ loaded: true }));
  };

  render() {
    let { className, loadedClassName, loadingClassName, ...props } = this.props;

    className = `${className} ${this.state.loaded
      ? loadedClassName
      : loadingClassName}`;

    return (
      <div className={className} ref="foo">
        <img 
          src={this.state.imgSrc} 
          className={className} 
          onLoad={this.onLoad}  />
      </div>
    )
  }
}

export default ImageLoader;