part of 'get_weather_cubit_cubit.dart';

@immutable
sealed class WeatherState {}

final class WeatherInitial extends WeatherState {}
final class WeatherLoadedState extends WeatherState {

}
final class WeatherFailureState extends WeatherState {
 final String errMessage;

  WeatherFailureState(this.errMessage);
}

