//! 主应用组件

use gpui::*;
use std::sync::Arc;
use crate::client::ApiClient;

pub struct RikkaApp {
    api_client: Arc<ApiClient>,
    selected_model: String,
    messages: Vec<ChatMessage>,
    input_text: String,
    is_loading: bool,
}

#[derive(Clone, Debug)]
struct ChatMessage {
    role: String,
    content: String,
}

impl RikkaApp {
    pub fn new() -> Self {
        Self {
            api_client: Arc::new(ApiClient::local()),
            selected_model: "gpt-3.5-turbo".to_string(),
            messages: vec![],
            input_text: String::new(),
            is_loading: false,
        }
    }
}

impl Render for RikkaApp {
    fn render(&mut self, _window: &mut Window, _cx: &mut Context<Self>) -> impl IntoElement {
        div()
            .flex()
            .flex_col()
            .size_full()
            .bg(rgb(0x1e1e2e))
            .text_color(rgb(0xcdd6f4))
            .child(
                // 标题栏
                div()
                    .h(px(48.0))
                    .px_4()
                    .flex()
                    .items_center()
                    .justify_between()
                    .border_b_1()
                    .border_color(rgb(0x313244))
                    .child(
                        div()
                            .text_xl()
                            .font_semibold()
                            .child("RikkaHub Desktop - 测试界面"),
                    )
                    .child(
                        div()
                            .text_sm()
                            .text_color(rgb(0x6c7086))
                            .child("Windows 测试版本"),
                    ),
            )
            .child(
                // 工具栏
                div()
                    .h(px(40.0))
                    .px_4()
                    .flex()
                    .items_center()
                    .gap_2()
                    .border_b_1()
                    .border_color(rgb(0x313244))
                    .child(
                        div()
                            .text_xs()
                            .text_color(rgb(0x6c7086))
                            .child("模型:"),
                    )
                    .child(
                        div()
                            .px_3()
                            .py_1()
                            .bg(rgb(0x313244))
                            .rounded_md()
                            .text_sm()
                            .child(&self.selected_model),
                    )
                    .child(
                        div()
                            .flex_1()
                    )
                    .child(
                        div()
                            .text_xs()
                            .text_color(if self.is_loading { rgb(0xf9e2af) } else { rgb(0xa6e3a1) })
                            .child(if self.is_loading { "● 连接中..." } else { "● 已连接" }),
                    ),
            )
            .child(
                // 消息列表区
                div()
                    .flex_1()
                    .flex()
                    .flex_col()
                    .overflow_y_scroll()
                    .px_4()
                    .py_4()
                    .gap_3()
                    .children(self.messages.iter().map(|msg| {
                        div()
                            .w_full()
                            .px_4()
                            .py_3()
                            .rounded_lg()
                            .max_w(px(800.0))
                            .when(msg.role == "user", |div| {
                                div.ml_auto().bg(rgb(0x45475a))
                            })
                            .when(msg.role == "assistant", |div| {
                                div.mr_auto().bg(rgb(0x313244))
                            })
                            .child(
                                div()
                                    .text_xs()
                                    .text_color(rgb(0x6c7086))
                                    .mb_1()
                                    .child(if msg.role == "user" { "用户" } else { "助手" }),
                            )
                            .child(
                                div()
                                    .text_sm()
                                    .line_height(rel(1.5))
                                    .child(&msg.content),
                            )
                    }))
                    .when(self.messages.is_empty(), |div| {
                        div.child(
                            div()
                                .flex()
                                .flex_col()
                                .items_center()
                                .justify_center()
                                .size_full()
                                .gap_2()
                                .child(
                                    div()
                                        .text_2xl()
                                        .font_semibold()
                                        .text_color(rgb(0x89b4fa))
                                        .child("🤖 RikkaHub"),
                                )
                                .child(
                                    div()
                                        .text_color(rgb(0x6c7086))
                                        .child("输入消息开始测试对话"),
                                )
                                .child(
                                    div()
                                        .mt_4()
                                        .px_4()
                                        .py_2()
                                        .bg(rgb(0x313244))
                                        .rounded_md()
                                        .text_xs()
                                        .text_color(rgb(0x6c7086))
                                        .child("提示: 此界面连接本地 API (http://localhost:3000)"),
                                )
                        )
                    }),
            )
            .child(
                // 输入区
                div()
                    .h(px(120.0))
                    .border_t_1()
                    .border_color(rgb(0x313244))
                    .px_4()
                    .py_3()
                    .flex()
                    .flex_col()
                    .gap_2()
                    .child(
                        div()
                            .text_xs()
                            .text_color(rgb(0x6c7086))
                            .child("输入消息:"),
                    )
                    .child(
                        div()
                            .flex_1()
                            .flex()
                            .gap_2()
                            .child(
                                div()
                                    .flex_1()
                                    .px_3()
                                    .py_2()
                                    .bg(rgb(0x313244))
                                    .rounded_md()
                                    .border_1()
                                    .border_color(rgb(0x45475a))
                                    .child(
                                        div()
                                            .text_sm()
                                            .text_color(rgb(0xcdd6f4))
                                            .child(if self.input_text.is_empty() {
                                                "在此输入消息..."
                                            } else {
                                                &self.input_text
                                            }),
                                    ),
                            )
                            .child(
                                div()
                                    .px_6()
                                    .py_2()
                                    .bg(rgb(0x89b4fa))
                                    .text_color(rgb(0x1e1e2e))
                                    .rounded_md()
                                    .text_sm()
                                    .font_semibold()
                                    .when(self.is_loading || self.input_text.is_empty(), |div| {
                                        div.opacity(0.5)
                                    })
                                    .child(if self.is_loading { "发送中..." } else { "发送" }),
                            ),
                    ),
            )
    }
}
