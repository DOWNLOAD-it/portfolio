import Hero from "./components/Hero";
import Projects from "./components/Projects";
import Education from "./components/Education";
import Experience from "./components/Experience";
import "./App.css";

const App = () => {
  return (
    <div className="app-container">
      <Hero />
      <Projects />
      <Education />
      <Experience />
    </div>
  );
};

export default App;
