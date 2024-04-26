import projectImage from "./images/projects/1.jpg";
import "./styles/Projects.css";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faReact, faLaravel } from "@fortawesome/free-brands-svg-icons";

const Projects = () => {
  return (
    <div className="projects-container">
      <div className="project-card">
        <div className="card-content">
          <h1 className="project-name">Best gaming site ever</h1>
          <div className="project-techstack">
            <FontAwesomeIcon icon={faReact} />
            <FontAwesomeIcon icon={faLaravel} />
          </div>
        </div>
        <img src={projectImage} alt="" />
      </div>
      <div className="project-card">
        <div className="card-content">
          <h1 className="project-name">Best gaming site ever</h1>
          <div className="project-techstack">
            <FontAwesomeIcon icon={faReact} />
            <FontAwesomeIcon icon={faLaravel} />
          </div>
        </div>
        <img src={projectImage} alt="" />
      </div>
      <div className="project-card">
        <div className="card-content">
          <h1 className="project-name">Best gaming site ever</h1>
          <div className="project-techstack">
            <FontAwesomeIcon icon={faReact} />
            <FontAwesomeIcon icon={faLaravel} />
          </div>
        </div>
        <img src={projectImage} alt="" />
      </div>
    </div>
  );
};

export default Projects;
