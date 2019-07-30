import ReactOnRails from 'react-on-rails';

import HelloWorld from '../bundles/HelloWorld/components/HelloWorld';
import SubmissionApplication from '../bundles/HelloWorld/components/SubmissionApplication';
import Search from '../bundles/HelloWorld/components/Search';
import Submission from '../bundles/HelloWorld/components/Submission';

// This is how react_on_rails can see the HelloWorld in the browser.
ReactOnRails.register({
  HelloWorld,
  SubmissionApplication,
  Search,
  Submission
});
