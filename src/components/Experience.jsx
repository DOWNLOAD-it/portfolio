import "./styles/Experience.css";

const Experience = () => {
  return (
    <div className="experience-container">
      <h1 className="section-title">My experience</h1>
      <div className="experience-card">
        <h1 className="experience-title">Information technology operator</h1>
        <h1 className="experience-at">NICOLAS</h1>
        <p>
          <span className="from"></span>
          <span className="to"></span>
        </p>
      </div>
      <div className="experience-card">
        <h1 className="experience-title">Wevservices developer internship</h1>
        <h1 className="experience-at">INETUM</h1>
        <p>
          <span className="from"></span>
          <span className="to"></span>
        </p>
      </div>
      <div className="experience-card">
        <h1 className="experience-title">Web developer internship</h1>
        <h1 className="experience-at">IOXIS</h1>
        <p>
          <span className="from"></span>
          <span className="to"></span>
        </p>
      </div>
    </div>
  );
};

export default Experience;
