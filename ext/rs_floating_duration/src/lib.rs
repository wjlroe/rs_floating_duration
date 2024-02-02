use floating_duration::TimeFormat;
use magnus::{function, prelude::*, Error, Ruby};
use std::time::Duration;

fn time_format(seconds: f64) -> String {
    format!("{}", TimeFormat(Duration::from_secs_f64(seconds)))
}

fn time_format_long(seconds: f64) -> String {
    format!("{:#}", TimeFormat(Duration::from_secs_f64(seconds)))
}

#[magnus::init]
fn init(ruby: &Ruby) -> Result<(), Error> {
    let module = ruby.define_module("RsFloatingDuration")?;
    module.define_singleton_method("time_format", function!(time_format, 1))?;
    module.define_singleton_method("time_format_long", function!(time_format_long, 1))?;
    Ok(())
}
