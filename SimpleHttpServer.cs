using System;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Threading.Tasks;

class SimpleHttpFileServer
{
    private readonly HttpListener _listener;

    public SimpleHttpFileServer()
    {
        _listener = new HttpListener();
    }

    public async Task Start(string url, string basePath)
    {
        _listener.Prefixes.Add(url);
        _listener.Start();

        Console.WriteLine($"Serving files from {basePath} on {url}");

        while (true)
        {
            HttpListenerContext context = await _listener.GetContextAsync();
            ProcessRequest(context, basePath);
        }
    }

    private async void ProcessRequest(HttpListenerContext context, string basePath)
    {
        string path = Path.Combine(basePath, context.Request.Url.LocalPath.TrimStart('/'));

        if (Directory.Exists(path))
        {
            await SendDirectoryListing(context, path, basePath);
        }
        else if (File.Exists(path))
        {
            await SendFile(context, path);
        }
        else
        {
            SendNotFound(context);
        }
    }

    private async Task SendDirectoryListing(HttpListenerContext context, string path, string basePath)
    {
        string[] files = Directory.GetFiles(path);
        string[] directories = Directory.GetDirectories(path);

        string fileList = string.Join("<br/>", directories.Select(d => $"<a href=\"{Uri.EscapeUriString(d.Substring(basePath.Length))}/\">{Path.GetFileName(d)}/</a>")
            .Concat(files.Select(f => $"<a href=\"{Uri.EscapeUriString(f.Substring(basePath.Length))}\">{Path.GetFileName(f)}</a>")));

        string htmlResponse = $"<html><head><title>Index of {context.Request.Url.LocalPath}</title></head><body><pre>{fileList}</pre></body></html>";

        byte[] responseBytes = Encoding.UTF8.GetBytes(htmlResponse);

        context.Response.ContentType = "text/html";
        context.Response.ContentLength64 = responseBytes.Length;
        context.Response.StatusCode = (int)HttpStatusCode.OK;

        using (Stream outputStream = context.Response.OutputStream)
        {
            await outputStream.WriteAsync(responseBytes, 0, responseBytes.Length);
        }

        context.Response.Close();
    }

    private async Task SendFile(HttpListenerContext context, string path)
    {
        byte[] responseBytes = File.ReadAllBytes(path);

        context.Response.ContentType = "application/octet-stream";
        context.Response.ContentLength64 = responseBytes.Length;
        context.Response.StatusCode = (int)HttpStatusCode.OK;

        context.Response.AddHeader("Content-Disposition", $"attachment; filename={Path.GetFileName(path)}");

        using (Stream outputStream = context.Response.OutputStream)
        {
            await outputStream.WriteAsync(responseBytes, 0, responseBytes.Length);
        }

        context.Response.Close();
    }

    private void SendNotFound(HttpListenerContext context)
    {
        context.Response.StatusCode = (int)HttpStatusCode.NotFound;
        context.Response.Close();
    }

    public void Stop()
    {
        _listener.Stop();
    }
}

class Program
{
    static async Task Main(string[] args)
    {
        
        string url = "http://localhost:8080/";
        string basePath = Directory.GetCurrentDirectory(); // 或者指定其他目录

        SimpleHttpFileServer server = new SimpleHttpFileServer();
        server.Stop();
        await server.Start(url, basePath);

        Console.WriteLine("Press any key to stop the server...");
        Console.ReadKey();
        
    }
}
