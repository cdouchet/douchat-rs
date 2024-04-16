use diesel::{
    deserialize::FromSqlRow, dsl::AsExprOf, expression::AsExpression, pg::Pg, sql_types::Text,
};
use serde::{Deserialize, Serialize};

#[derive(Debug, FromSqlRow, Serialize, Deserialize, PartialEq, Eq)]
#[serde(rename_all = "snake_case")]
pub enum MessageType {
    User,
    System,
}

impl core::fmt::Display for MessageType {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        write!(
            f,
            "{}",
            match *self {
                MessageType::User => "user",
                MessageType::System => "system",
            }
        )
    }
}

impl FromSqlRow<Text, Pg> for MessageType {
    fn build_from_row<'a>(
        row: &impl diesel::row::Row<'a, Pg>,
    ) -> diesel::deserialize::Result<Self> {
        match String::build_from_row(row)?.as_ref() {
            "user" => Ok(MessageType::User),
            "system" => Ok(MessageType::System),
            e => Err(format!("Unknown value {} for MessageType found", e).into()),
        }
    }
}

impl AsExpression<Text> for MessageType {
    type Expression = AsExprOf<String, Text>;
    fn as_expression(self) -> Self::Expression {
        <String as AsExpression<Text>>::as_expression(self.to_string())
    }
}

impl<'a> AsExpression<Text> for &'a MessageType {
    type Expression = AsExprOf<String, Text>;
    fn as_expression(self) -> Self::Expression {
        <String as AsExpression<Text>>::as_expression(self.to_string())
    }
}
