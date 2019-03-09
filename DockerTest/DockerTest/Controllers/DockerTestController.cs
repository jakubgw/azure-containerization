using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;

namespace DockerTest.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class DockerTestController : ControllerBase
    {
        // GET api/values
        [HttpGet]
        public ActionResult<IEnumerable<string>> Get()
        {
            return new string[] { "Hi", "I", "am", "docker", "test" };
        }
    }
}
