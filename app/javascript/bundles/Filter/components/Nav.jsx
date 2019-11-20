import React from 'react';
import Logo from 'images/logo-2019-inverted.png'
import SquareLogo from 'images/main-logo-black-squished.jpg'

import Key from './Key.jsx'
import Form from './Form.jsx'


export default class Nav extends React.Component {
  constructor(props) {
    super(props);
    this.state = {     
      collapsed: true
    }

  }

  // this is really hacky and bad, but I'm really tired.
  toggleNav = () => {
    this.setState({collapsed: !this.state.collapsed});
    this.props.handleToggleNav()
  }

  
  render() {
    const {collapsed} = this.state
    return (
      <nav className={collapsed ? "collapsed" : "full"}>
        
        {collapsed ? (
          // collapsed nav
          <div className="f1 lh-solid">
            <img src={SquareLogo} onClick={this.toggleNav}/>

          </div>

        ) : (
          // normal nav
          <div>
            <img src={Logo} onClick={this.toggleNav} className="hidden display-desktop mb5"/>
            <div className="mb5">
              <button 
                className={this.props.viewDataVis ? "w-50 br--left active-button" : "w-50 br--left"} 
                onClick={this.props.handleToggle}>Data</button>
              <button 
                className={this.props.viewDataVis ? "w-50 br--right white" : "w-50 br--right active-button"} 
                onClick={this.props.handleToggle}>Images</button>
            </div>
            <Form siteNames={this.props.siteNames} refineView={this.props.refineView} />
            <Key />
          </div>
        )}

      </nav>
    )
  }
}