import React from 'react';

import SubmissionBarChart from './data/SubmissionBarChart'
// import SubmissionAreaChart from './data/SubmissionAreaChart'
import TagScatterChart from './data/TagScatterChart'
import TypePieChart from './data/TypePieChart'

export default class DataVis extends React.Component {
  constructor(props){
    super(props)
  }
  

  render() {

    const {submissionsData} = this.props
    const dailyData = submissionsData != "undefined" ? submissionsData.byMonth : []
    const typeData = submissionsData != 'undefined' ? submissionsData.types : []
    const tagData = submissionsData != 'undefined' ? submissionsData.tags : []
    const maxData = submissionsData != 'undefined' ? submissionsData.maxSubs : []
    const minData = submissionsData != 'undefined' ? submissionsData.minSubs : []
    
    const maxTags = submissionsData != 'undefined' ? submissionsData.tags.slice(Math.max(submissionsData.tags.length - 5, 1)) : []
    
    return (
      <div>
        {/* project wide states */}
        <div className="pa4 mt4 br2 data-box">
          <h2 className="mb4 f1 title ">Project wide stats</h2>
          <div className="flex-ns items-end">
            <div className="w-30">
              <h1 className="data-bold-color">{this.props.allSubmissionsTotal}</h1> 
              <hr className="w-60 ml0"></hr>
              Total
            </div>
            
            <div>
              {maxData.map((site)=>(<h3 className="f2 mb3 data-bold-color">{site}</h3>))}
              <hr className="w-60 ml0"></hr>
              Most popular
            </div>  

            <div>
              {minData.map((site)=>(<h3 className="f2 mb3 data-bold-color">{site}</h3>))}
              <hr className="w-60 ml0"></hr>
              Least popular
            </div>
            
            <div className="w-80 w-40-ns">
              <TypePieChart data={typeData} />
              <hr className="w-60 ml0"></hr>
              Type breakdown
            </div>
          </div>
          {/* Eventually there will be a snazzy area chart... if I can be bothered... */}
          {/* <SubmissionAreaChart data={dailyData} /> */}
        </div>


        {/*   Site Specific stats */}
        <div className="pa4 mt4 br2 data-box">
          <h2 className="mb4 f1 title mb2">Stats for {this.props.siteName ? this.props.siteName : "all sites"}</h2>
        
          <h1 className="f2 f1-l lh-title mb0 mt4 data-bold-color">Submission numbers over the year</h1>
          <SubmissionBarChart data={dailyData} />
          <hr className="w-60 ml0 mt0"></hr>

          <div className="flex-ns">
            <div className="w-100 w-60-ns">
              <h1 className="f2 f1-l lh-title mb0 mt4 data-bold-color">Vision AI tags</h1>
              <TagScatterChart data={tagData} />
            </div>
            <div>
              <table>
                <tbody>
                  <tr>
                    <th>Label</th>
                    <th>Tags</th>
                    <th>Av. confidence</th>
                  </tr>
                  {maxTags.map((tag) => (<tr><td>{tag["label"]}</td><td>{tag["y"]}</td><td>{tag["x"]}</td></tr>))}
                </tbody>
              </table>
            </div>
          </div>

        </div>




      </div>
    )
  }
}