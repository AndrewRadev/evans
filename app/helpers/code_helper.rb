module CodeHelper
  def format_code(code_text, language = Language.language)
    formatted_code = FormattedCode::Code.new(code_text, language, [])

    render '_formatted_code/code', code: formatted_code, copyable_code: code_text, commentable: false
  end

  def solution_code(formatted_code, revision, commentable, copyable_code: nil)
    render '_formatted_code/code',
      code: formatted_code,
      copyable_code: copyable_code,
      commentable: commentable,
      form_partial: 'solutions/inline_comment_form',
      form_partial_args: { revision: revision }
  end

  def inline_comment(comment)
    render '_formatted_code/inline_comment', comment: InlineCommentDecorator.decorate(comment)
  end
end
