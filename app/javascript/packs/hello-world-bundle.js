import ReactOnRails from 'react-on-rails';

import HelloWorld from '../bundles/HelloWorld/components/HelloWorld';
import SubmissionApplication from '../bundles/HelloWorld/components/SubmissionApplication';
import Search from '../bundles/HelloWorld/components/Search';

// This is how react_on_rails can see the HelloWorld in the browser.
ReactOnRails.register({
  HelloWorld,
  SubmissionApplication,
  Search
});
