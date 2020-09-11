import React from 'react';

export default class Key extends React.Component {
  constructor(props) {
    super(props);
  }

  Greeting = (props) => {
    const isLoggedIn = props.userEmail;
    if (isLoggedIn) {
      return <UserGreeting />;
    }
    return <GuestGreeting />;
  }
  
  UserGreeting = (props) => {
    return <h1>Welcome back!</h1>;
  }
  
  GuestGreeting(props) {
    return <h1>Please sign up.</h1>;
  }

  render() {
    const isLoggedIn = this.props.userEmail;
    return (

      <div className="dn-m flex-ns flex-wrap justify-around items-center mt0 mb0 absolute-ns bottom-0-ns w-100">
 
        <div className="pv3 tc w-100">{isLoggedIn ? 'Logged in as ' + this.props.userEmail : 'Not logged in'}</div>
        <div className="pv3 tc w-100"><a href="/users/sign_in">Login/Logout</a></div>
        <div className="pv3 tc w-100">Key</div>
        <div className="pv3 tc w-25 whatsapp">WhatsApp</div>
        <div className="pv3 tc w-25 twitter">Twitter</div>
        <div className="pv3 tc w-25 instagram">Instagram</div>
        <div className="pv3 tc w-25 email">Email</div>
      </div>
    )
  }
}