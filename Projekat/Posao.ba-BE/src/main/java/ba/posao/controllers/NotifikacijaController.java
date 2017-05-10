package ba.posao.controllers;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.ResponseBody;

import ba.posao.models.Notifikacija;
import ba.posao.repositories.NotifikacijaRepository;

@Controller    // This means that this class is a Controller
@RequestMapping(path="/notifikacije") 
public class NotifikacijaController {
	@Autowired
	
	private NotifikacijaRepository notifikacijaRepository;
	
	@GetMapping(path="/{id}")
	public @ResponseBody Notifikacija getNotifikacijaById(@PathVariable("id") Integer id) {
		return notifikacijaRepository.findById(id);
	}
}