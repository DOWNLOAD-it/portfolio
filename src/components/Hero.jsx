import { useEffect, useState } from "react";
import "./styles/Hero.css";

const Hero = () => {
  const [text] = useState(
    "i'm a fullstack devloper. I like working on front-end of the web as well as back-end applications. I'm a passionate software developer, specializing in languages such as PHP, JavaScript, and Python, as well as frameworks like React and Laravel. I have solid experience in Git, Agile Scrum, and UML modeling."
  );

  const [description, setDescription] = useState("");

  useEffect(() => {
    let i = 0;
    const timer = setInterval(() => {
      if (i < text.length - 1) {
        setDescription((prevDescription) => prevDescription + text[i]);
        i++;
      } else {
        clearInterval(timer);
      }
    }, 30);

    return () => clearInterval(timer);
  }, [text]);

  return (
    <div className="hero-container">
      <div className="hero-content">
        <h1 className="hero-content-title">
          <span>hi there,</span>
          i'm abderrahmane
          <span>FULLSTACK Developer</span>
        </h1>
        <p className="hero-content-description">{description}</p>
      </div>
    </div>
  );
};

export default Hero;
