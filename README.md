# Ground Truth API
This is the home of the Ground Truth API.

## Mission
**Ground Truth gives everyone the opportunity to report their symptoms anonymously for the benefit of others. Our mission is to map the movement of infection and disease across the world, and provide unrestricted access to this data.**

## What is Ground Truth?
Ground Truth is a suite of apps and services that aim to crowd-source symptom data for the benefit of others. The data captured is free for anyone to read and use in their research or systems. Ground Truth is a data tool, and is not interested in capturing any possibly personally identifying information.

## What could Ground Truth be used for?
Here's just a few ideas:

🌍 Using computer programming or AI / ML models to map the movement of symptoms across the globe

🚨 Using the platform as an early warning system in developing countries

🚑 Essential supplies / logistical planning by using the system to find out where the most help might be needed

## Where can i get the data?
There are several endpoints that power the webapp, the iOS and Android apps.

GET [https://api.groundtruth.app/hotspots](https://api.groundtruth.app/hotspots)
Returns a JSON array of hotspot objects. A "hotspot" is simply a report received from n anonymous Ground Truth user.

GET [https://api.groundtruth.app/layers](https://api.groundtruth.app/layers)
Returns a JSON array of layer objects. A "layer" is an information layer for a particular symptom, such as a "sneeze" or a "cough". Every hotspot is associated to a layer.

GET [https://api.groundtruth.app/statistics](https://api.groundtruth.app/statistics)
Returns a JSON array of statistic objects that provide surface counts for database entries.

## Social?
Join us over on Telegram: [https://t.me/groundtruthapp](https://t.me/groundtruthapp)

## What is the technology stack for this API?
This is a Firebase-flavoured micrservice based API.

## Who maintains this project?
The Ground Truth network is maintained by Kieran Goodary and Digital Industria Ltd. You can email the developer [by clicking here](mailto:apps@digitalindustria.com).

## Supporters and sponsors

### ❤️ [Algolia](https://www.algolia.com)
Thank you to Algolia for providing us with a free Pro account. We are now able to turbo-charge our data and provide geospatial queries for everyone.

![Algolia](https://res.cloudinary.com/hilnmyskv/image/upload/q_auto/v1584543140/Algolia_com_Website_assets/images/shared/algolia_logo/logo-algolia-nebula-blue-full.png)

## License

Copyright 2020 Kieran Goodary, Digital Industria Ltd

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

