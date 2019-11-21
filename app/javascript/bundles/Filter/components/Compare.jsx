import React from 'react';
import ReactModal from 'react-modal';

import ImagePreview from './ImagePreview.jsx'
import ReactCompareImage from 'react-compare-image';


export default class Compare extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      modalIsOpen: false,
      compareHeight: 0,
      compareWidth: 0,
    };
  }

  handleOpenModal = () => {
    this.setState({ showModal: true });
  }
  
  handleCloseModal = () => {
    this.setState({ showModal: false });
  }

  render() {
    const imagesArray = this.props.imageCompare
    const imagesPresent = imagesArray && imagesArray.length === 2
    const aspectRatio = this.props.compareWidth / this.props.compareHeight
    const height = Math.floor(window.innerHeight * 0.8)
    const divStyle = {
      height: height,
      width: height / aspectRatio,
      margin: '0 auto',
    }

    return (
      <div id="compareModal" className="flex flex-wrap justify-around items-center h4 mt0 mb3 sticky blue-background">
        <div className="pv4 tc w-25"><ImagePreview index="0" imageCompare={imagesArray} /></div>
        <div className="pv4 tc w-25"><ImagePreview index="1" imageCompare={imagesArray} /></div>
        <div className="pv3 tc w-50">
          {imagesPresent &&
            <button onClick={this.handleOpenModal}>Compare images</button>
          }
        </div>

        <ReactModal 
           isOpen={this.state.showModal}
           contentLabel="Minimal Modal Example"
           ariaHideApp={false}
        >
          <p className="dark-color tc">Move the cursor across the images to compare them</p>

          <div style={divStyle}>
            <ReactCompareImage className="image-compare" leftImage={imagesArray[0]} rightImage={imagesArray[1]} />;
          </div>
          
          <button className="flex center mv3" onClick={this.handleCloseModal}>Close Modal</button>
        </ReactModal>
      </div>
    )
  }
}