package it.prova.raccoltafilmspringmvc.web.controller;

import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

import it.prova.raccoltafilmspringmvc.model.Regista;
import it.prova.raccoltafilmspringmvc.service.RegistaService;

@Controller
@RequestMapping(value = "/regista")
public class RegistaController {

	@Autowired
	private RegistaService registaService;

	@GetMapping
	public ModelAndView listAllRegisti() {
		ModelAndView mv = new ModelAndView();
		List<Regista> registi = registaService.listAllElements();
		mv.addObject("registi_list_attribute", registi);
		mv.setViewName("regista/list");
		return mv;
	}

	@GetMapping("/insert")
	public String createRegista(Model model) {
		model.addAttribute("insert_regista_attr", new Regista());
		return "regista/insert";
	}

	@PostMapping("/save")
	public String saveRegista(@Valid @ModelAttribute("insert_regista_attr") Regista regista, BindingResult result,
			RedirectAttributes redirectAttrs) {
		if (result.hasErrors()) {
			return "regista/insert";
		}
		registaService.inserisciNuovo(regista);

		redirectAttrs.addFlashAttribute("successMessage", "Operazione eseguita correttamente");
		return "redirect:/regista";
	}

	@GetMapping("/search")
	public String searchRegista() {
		return "regista/search";
	}

	@PostMapping("/list")
	public String listRegisti(Regista registaExample, ModelMap model) {
		List<Regista> registi = registaService.findByExample(registaExample);
		model.addAttribute("registi_list_attribute", registi);
		return "regista/list";
	}

	@GetMapping(value = "/searchRegistiAjax", produces = { MediaType.APPLICATION_JSON_VALUE })
	public @ResponseBody String searchRegista(@RequestParam String term) {

		List<Regista> listaRegistaByTerm = registaService.cercaByCognomeENomeILike(term);
		return buildJsonResponse(listaRegistaByTerm);
	}

	private String buildJsonResponse(List<Regista> listaRegisti) {
		JsonArray ja = new JsonArray();

		for (Regista registaItem : listaRegisti) {
			JsonObject jo = new JsonObject();
			jo.addProperty("value", registaItem.getId());
			jo.addProperty("label", registaItem.getNome() + " " + registaItem.getCognome());
			ja.add(jo);
		}

		return new Gson().toJson(ja);
	}

	@GetMapping("/show/{idRegista}")
	public String showRegista(@PathVariable(required = true) Long idRegista, Model model) {
		model.addAttribute("show_reg_attr", registaService.caricaSingoloElemento(idRegista));
		return "regista/show";
	}

	@GetMapping("/edit/{idRegista}")
	public String editRegista(@PathVariable(required = true) Long idRegista, Model model) {
		model.addAttribute("registi_attribute", registaService.caricaSingoloElemento(idRegista));
		return "regista/edit";
	}

	@PostMapping("/edit/update")
	public String updateRegista(@Valid @ModelAttribute("regista_attribute") Regista regista,
			@Valid @ModelAttribute("idRegista") Long idRegista, BindingResult result,
			RedirectAttributes redirectAttrs) {

		if (result.hasErrors()) {
			return "regista/edit";
		}

		regista.setId(idRegista);
		registaService.aggiorna(regista);

		redirectAttrs.addFlashAttribute("successMessage", "Operazione eseguita correttamente");
		return "redirect:/regista";
	}

	@GetMapping("/delete/{idRegista}")
	public String controllaDeleteRegista(@PathVariable(required = true) Long idRegista, Model model) {
		model.addAttribute("regista_delete", registaService.caricaSingoloElemento(idRegista));
		return "/regista/delete";
	}

	@PostMapping("/delete/execute")
	public String controllaDeleteRegista(@Valid @ModelAttribute("idRegista") Long idRegista, BindingResult result,
			RedirectAttributes redirectAttrs) {

		if (!registaService.caricaSingoloElementoConFilms(idRegista).getFilms().isEmpty()) {
			redirectAttrs.addFlashAttribute("errorMessage", "Impossibile eliminare registi con film ancora associati.");
			return "redirect:/regista";
		}
		registaService.rimuovi(registaService.caricaSingoloElemento(idRegista));

		redirectAttrs.addFlashAttribute("successMessage", "Operazione eseguita correttamente");
		return "redirect:/regista";
	}
//-------------------------------by ANDRE------------------------------------------
//-------altro modo di gestire eliminazione regista con film, utilizzando l'eccezione
//-------della constraint key senza nessun caricamento eager fatto ad hoc
//	
//	try {
//	registaService.rimuovi(regista);
//	redirectAttrs.addFlashAttribute("successMessage", "Operazione eseguita correttamente");
//} catch (Exception e) {
//	e.printStackTrace();
//	redirectAttrs.addFlashAttribute("errorMessage", "Non puoi eliminare un regista se ha i sui film.");
//}
//return "redirect:/regista";

}
