use diesel::{
    deserialize::FromSqlRow, dsl::AsExprOf, expression::AsExpression, pg::Pg, sql_types::Text,
};
use serde::{Deserialize, Serialize};

#[derive(Debug, FromSqlRow, Serialize, Deserialize, PartialEq, Eq)]
#[serde(rename_all = "snake_case")]
pub enum RoomType {
    Dialogue,
    Group,
}

impl core::fmt::Display for RoomType {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        write!(
            f,
            "{}",
            match *self {
                RoomType::Dialogue => "dialogue",
                RoomType::Group => "group",
            }
        )
    }
}

impl FromSqlRow<Text, Pg> for RoomType {
    fn build_from_row<'a>(
        row: &impl diesel::row::Row<'a, Pg>,
    ) -> diesel::deserialize::Result<Self> {
        match String::build_from_row(row)?.as_ref() {
            "dialogue" => Ok(RoomType::Dialogue),
            "group" => Ok(RoomType::Group),
            e => Err(format!("Unknown value {} for RoomType found", e).into()),
        }
    }
}

impl AsExpression<Text> for RoomType {
    type Expression = AsExprOf<String, Text>;
    fn as_expression(self) -> Self::Expression {
        <String as AsExpression<Text>>::as_expression(self.to_string())
    }
}

impl<'a> AsExpression<Text> for &'a RoomType {
    type Expression = AsExprOf<String, Text>;
    fn as_expression(self) -> Self::Expression {
        <String as AsExpression<Text>>::as_expression(self.to_string())
    }
}
