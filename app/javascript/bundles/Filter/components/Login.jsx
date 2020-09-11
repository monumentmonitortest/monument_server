import React from 'react';

class Login extends React.Component {
  constructor(props) {
    super(props);
  }

  NotLoggedIn = () => {
    return (
      <div className="w-100 flex-ns flex-wrap">
        <div className="pv3 tc w-50">Not logged in</div>
        <div className="pv3 tc w-25"><a href="/users/sign_in">Sign in</a></div>
        <div className="pv3 tc w-25"><a href="/users/sign_up">Sign up</a></div>
      </div>
    )
  }
  
  LoggedIn = () => {
    return (
      <div className="w-100">
        <div className="pv3 tc w-100">
          Logged in as {this.props.userEmail}, <a href='/admin' >Logout</a>
        </div> 
      </div>
    )
  }

  render() {
    // if props empty string, they are not logged in
		const isNotLoggedIn = this.props.userEmail.trim() == "";
    return (
			<div className="dn-m flex-ns flex-wrap justify-around items-center mt0 mb0  w-100">
        {isNotLoggedIn ? <this.NotLoggedIn/> : <this.LoggedIn /> }
			</div>
    );
  }
}

export default Login