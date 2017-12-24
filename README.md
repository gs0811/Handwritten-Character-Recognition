# Handwritten-Character-Recognition
Dataset : http://lipitk.sourceforge.net/hpl-datasets.htm
Conference paper link: http://ieeexplore.ieee.org/document/7872700/
The project was focused on designing and implementing a system to recognize handwritten characters. Different features from the training set were collected and a model was prepared. When a new test set arrives it goes through different phases like pre-processing, segmentation, feature extraction and classification for recognizing a character. It achieved a very good accuracy of 88.8% for Telugu language handwritten characters and IEEE research paper has been published on the same (link provided above).
It involved 3 feature extraction methods. One density based, two distance based. We normalized both features to lie in between 0 and 1 and combined them. The 3rd one involved geometric based features and genetic algorithms is used to get a good accuracy. KNN was used for classifying the characters.
