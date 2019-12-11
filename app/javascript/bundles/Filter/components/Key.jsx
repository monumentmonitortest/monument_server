import React from 'react';

export default class Key extends React.Component {
  constructor(props) {
    super(props);
  }
  
  render() {
    return (
      <div className="dn-m flex-ns flex-wrap justify-around items-center mt0 mb0 absolute-ns bottom-0-ns w-100">
        <div className="pv3 tc w-100">Key</div>
        <div className="pv3 tc w-25 whatsapp">WhatsApp</div>
        <div className="pv3 tc w-25 twitter">Twitter</div>
        <div className="pv3 tc w-25 instagram">Instagram</div>
        <div className="pv3 tc w-25 email">Email</div>
      </div>
    )
  }
}