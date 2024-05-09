import "./styles/Education.css";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faReact, faLaravel } from "@fortawesome/free-brands-svg-icons";

const Education = () => {
  return (
    <div className="education-container">
      <h1 className="section-title">My education</h1>
      <div className="education-card">
        <h1 className="education-title">specialized technician diploma</h1>
        <h1 className="education-specialisation">digital development</h1>
        <div className="skill-list">
          <FontAwesomeIcon icon={faLaravel} />
          <FontAwesomeIcon icon={faReact} />
        </div>
      </div>
      <div className="education-card">
        <h1 className="education-title">baccalaureat</h1>
        <h1 className="education-specialisation">
          electrical sciences and technologies
        </h1>
      </div>
    </div>
  );
};

export default Education;
