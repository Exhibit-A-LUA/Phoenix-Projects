defmodule DiabetesV1Web.MarkdownComponent do
  use Phoenix.Component
  import Phoenix.HTML

  def markdown_component(assigns) do
    # Read and parse the Markdown file
    {:ok, markdown_content} = File.read(assigns.file)
    {:ok, html_content, _warnings} = Earmark.as_html(markdown_content)

    # Assign the HTML content
    assigns = assign(assigns, :html_content, html_content)

    ~H"""
    <div class="markdown-content">
      {raw(@html_content)}
    </div>
    """
  end
end
