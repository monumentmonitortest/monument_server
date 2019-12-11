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
    const dailyData = this.props.submissionsData != "undefined" ? this.props.submissionsData.byMonth : []
    const typeData = this.props.submissionsData != 'undefined' ? this.props.submissionsData.types : []
    const tagData = this.props.submissionsData != 'undefined' ? this.props.submissionsData.tags : []
    const maxData = this.props.submissionsData != 'undefined' ? this.props.submissionsData.maxSubs : []
    const minData = this.props.submissionsData != 'undefined' ? this.props.submissionsData.minSubs : []
   
    return (
      <div>
        <div className="pa4 mt4 br2 data-box">
          <h2 className="mb4 f1 title ">Project wide stats</h2>
          <div className="flex items-end">
            <div className="w-30">
              <h1 className="data-bold-color">{this.props.allSubmissionsTotal}</h1> 
              <hr className="w-60 ml0"></hr>
              Submissions to date
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
            
            <div className="w-40">
              <TypePieChart data={typeData} />
            </div>
          </div>
        </div>







        {/* <SubmissionAreaChart data={dailyData} /> */}
        <SubmissionBarChart data={dailyData} />
        <TagScatterChart data={tagData} />
      </div>
    )
  }
}