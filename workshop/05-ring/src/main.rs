use std::collections::HashMap;
use std::fs::{File};
use std::io::{self, prelude::*, Error};
use std::process::Command;
use std::time::{SystemTime, UNIX_EPOCH};

use poem::error::InternalServerError;
use poem::{
    error::NotFoundError,
    get, handler,
    http::StatusCode,
    listener::TcpListener,
    web::{Form, Html },
    EndpointExt, IntoResponse, Response, Route, Server,
}; 

use serde_json::Value;
use tera::{Context, Tera};

#[macro_use]
extern crate lazy_static;

use serde::Deserialize;

//----------------------------------------------------------------------
// module five
//----------------------------------------------------------------------
lazy_static! {
    pub static ref TEMPLATES: Tera = {
        let mut tera = match Tera::new("templates/**/*") {
            Ok(t) => t,
            Err(e) => {
                println!("Parsing error(s): {}", e);
                ::std::process::exit(1);
            }
        };
        tera.autoescape_on(vec![".html", ".sql"]);
        tera
    };
}

#[derive(Deserialize)]
struct ModuleFiveParams {
    merchant_id: String,
    store_number: String,
    street: String,
    city: String,
    state: String,
    zip: String,
}

fn json_to_hashmap(path_string: &str) -> Result<HashMap<String, Value>, Error> {
    let path = std::path::Path::new(path_string);
    let mut file = File::open(&path)?;
    let mut contents = String::new();
    file.read_to_string(&mut contents)?;
    let file_values: HashMap<String, Value> =
        serde_json::from_str(contents.as_str().as_ref()).unwrap();
    Ok(file_values)
}

fn write_string_to_file(data: String, path_str: &str) -> Result<File, io::Error> {
    let mut file = File::create(path_str)?;
    file.write_all(data.as_bytes())?;
    Ok(file)
}

fn hab_config_apply() {
    //**** CAPTURE GROUP
    let output = Command::new("hab")
        .arg("sup")
        .arg("status")
        .arg("workshop/ring")
        .output().unwrap();

        let buffer = String::from_utf8(output.stdout).unwrap();
        let parts = buffer.split('.').collect::<Vec<_>>();
        let mut group = parts.last().unwrap().to_string();
        group.pop();

    //**** UPDATE SETTINGS
    let d = SystemTime::now().duration_since(UNIX_EPOCH).unwrap();
    let s = d.as_secs().to_string();

    let mut group_arg: String = "ring.".to_owned();
    group_arg.push_str(&group);
    
    let mut cmd = Command::new("hab");
    cmd.arg("config")
        .arg("apply")
        .arg(group_arg)
        .arg(s)
        .arg("/hab/svc/ring/files/changes.toml");

    let _output = cmd.output();
}

#[handler]
fn hander_index() -> Result<Html<String>, poem::Error> {
    let map = json_to_hashmap("/hab/svc/ring/config/application-settings.json").unwrap();

    let mut context = Context::new();
    context.insert("t_merchant_id", map.get("merchant_id").unwrap());
    context.insert("t_store_number", map.get("store_number").unwrap());
    context.insert("t_street", map.get("street").unwrap());
    context.insert("t_city", map.get("city").unwrap());
    context.insert("t_state", map.get("state").unwrap());
    context.insert("t_zip", map.get("zip").unwrap());

    TEMPLATES
        .render("index.html.tera", &context)
        .map_err(InternalServerError)
        .map(Html)
}


#[handler]
fn handler_change() -> Result<Html<String>, poem::Error> {
    let map = json_to_hashmap("/hab/svc/ring/config/application-settings.json").unwrap();

    let mut context = Context::new();
    context.insert("t_merchant_id", map.get("merchant_id").unwrap());
    context.insert("t_store_number", map.get("store_number").unwrap());
    context.insert("t_street", map.get("street").unwrap());
    context.insert("t_city", map.get("city").unwrap());
    context.insert("t_state", map.get("state").unwrap());
    context.insert("t_zip", map.get("zip").unwrap());

    TEMPLATES
        .render("change.html.tera", &context)
        .map_err(InternalServerError)
        .map(Html)
}

#[handler]
async fn handler_change_process(Form(params): Form<ModuleFiveParams>) -> Result<Html<String>, poem::Error> {
    let map = json_to_hashmap("/hab/svc/ring/config/application-settings.json").unwrap();

    let mut context = Context::new();
    context.insert("t_merchant_id", map.get("merchant_id").unwrap());
    context.insert("t_store_number", map.get("store_number").unwrap());
    context.insert("t_street", map.get("street").unwrap());
    context.insert("t_city", map.get("city").unwrap());
    context.insert("t_state", map.get("state").unwrap());
    context.insert("t_zip", map.get("zip").unwrap());
    
    context.insert("s_merchant_id", &params.merchant_id);
    context.insert("s_store_number", &params.store_number);
    context.insert("s_street", &params.street);
    context.insert("s_city", &params.city);
    context.insert("s_state", &params.state);
    context.insert("s_zip", &params.zip);

    
    
    let params= format!(
        "merchant_id = {:?}\nstore_number = {:?}\nstreet = {:?}\ncity = {:?}\nstate = {:?}\nzip = {:?}",
        params.merchant_id,
        params.store_number,
        params.street,
        params.city,
        params.state,
        params.zip
    );

    let _f = write_string_to_file(params, "changes.toml");
    hab_config_apply();

    
    TEMPLATES
        .render("refresh.html.tera", &context)
        .map_err(InternalServerError)
        .map(Html)
}

#[handler]
async fn module_five_process(Form(params): Form<ModuleFiveParams>) -> impl IntoResponse {
    let params= format!(
        "merchant_id = {:?}\nstore_number = {:?}\nstreet = {:?}\ncity = {:?}\nstate = {:?}\nzip = {:?}",
        params.merchant_id,
        params.store_number,
        params.street,
        params.city,
        params.state,
        params.zip
    );

    println!("PARAMS:\n{}", params);

    let f = write_string_to_file(params, "changes.toml");
    println!("F:{:#?}", f);

    hab_config_apply();

    let output = r###"
        <!DOCTYPE html>
        <html lang="en">
        <head>
            <title>Poem Toy</title>
            <meta charset="UTF-8">
            <style>
                body {
                  background-color:slategray;
                  color: linen;
                }
            </style>
        </head>
        <body>
            <p>Please give it a moment before going <a href="/">back to /</a>.  If it hasn't updated or hangs, please reload.</p>
        </body>
        </html>
        "###;

    Html(output)
}

//----------------------------------------------------------------------
// main
//----------------------------------------------------------------------
#[tokio::main]
async fn main() -> Result<(), std::io::Error> {
    if std::env::var_os("RUST_LOG").is_none() {
        std::env::set_var("RUST_LOG", "poem=debug,tera=debug");
    }
    tracing_subscriber::fmt::init();

    let app = Route::new()
        .at("/", get(hander_index))
        .at("/change", get(handler_change).post(handler_change_process))
        .catch_error(|_: NotFoundError| async move {
            Response::builder()
                .status(StatusCode::NOT_FOUND)
                .body("Something Went Wrong")
        });

    Server::new(TcpListener::bind("0.0.0.0:8005"))
        .run(app)
        .await
}
