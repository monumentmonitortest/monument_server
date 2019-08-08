import React from "react";
import ExifOrientationImg from 'react-exif-orientation-img'

const _loaded = {};

class ImageLoader extends React.Component {
  
  //initial state: image loaded stage 
  state = {
    loaded: _loaded[this.props.src]
  };

  //define our loading and loaded image classes
  static defaultProps = {
    className: "w-100 pointer",
    loadingClassName: "img-loading",
    loadedClassName: "img-loaded"
  };

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
      <div className={className}>
        <img 
          src={this.props.src} 
          onClick={()=> window.open(this.props.src, "_blank")} 
          className={className} 
          onLoad={this.onLoad}  />
      </div>
    )
  }
}

export default ImageLoader;