import 'package:flutter/rendering.dart';

const mobileMaxWidth = 500;
const tabletMaxWidth = 1100;

bool isMobile(BoxConstraints constraints) => constraints.maxWidth < mobileMaxWidth;
