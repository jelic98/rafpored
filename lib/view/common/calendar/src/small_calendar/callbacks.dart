import 'dart:async';

/// Callback with a [DateTime].
///
/// All values except year, month and day are set to their default values.
typedef void DateCallback(DateTime date);

/// Returns true/false if a [day] has some property.
typedef Future<bool> IsHasCallback(DateTime day);
